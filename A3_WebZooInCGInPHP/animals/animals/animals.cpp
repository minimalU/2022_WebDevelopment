// FILE          : animals.cpp
// PROJECT       : A03
// programmer    : Yujung Park
// FIRST VERSION : 2022-10-09
// DESCRIPTION   : This program is to demonstrate the CGI version operation of the server-side website.
//				   Along with the completion of form submission of client site of Zoo website, 
//                 this cgi animals.cpp file receives keyand value pair from the client side and 
//                 displays the animal's image and text for the selected animal by the user into HTML format.
//				   !!!!! All of animals pictures and contents are the property of Toronto ZOO.

#include <stdio.h>
#include <stdlib.h>
#include <iostream>

#pragma warning(disable : 4996)										// to use getenv()

void displayServerPage(char* imgFile, char* txtFile, char* animal);	// Prototype

int main()
{

	char* data = NULL;						// Evironment variable: QUERY_STRING for form submission value
	char* path_translated = NULL;			// Evironment variable: PATH_TRANSLATED to complete txt file path
	char* script_name = NULL;				// Evironment variable: SCRIPT_NAME to complete txt file path
	char copyData[100] = { 0 };				// Copy QUERY_STRING for parsing
	char user[50] = { 0 };
	char name[50] = { 0 };					// User name
	char animals[50] = { 0 };
	char animal[50] = { 0 };				// Animal selected
	char txtFile[100] = { 0 };
	char imgFile[100] = "./theZoo/";

	// print html
	printf("Content-type:text/html\r\n\r\n");
	printf("<html>\n");
	printf("<head>\n");
	printf("<title>CGI-ZOO</title>\n");
	printf("<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi\" crossorigin=\"anonymous\">\n");
	printf("</head>\n");
	printf("<body>\n");

	// get environment variables
	data = getenv("QUERY_STRING");
	path_translated = getenv("PATH_TRANSLATED");
	script_name = getenv("SCRIPT_NAME");

	// complete the file path ???????
	char* pBack = strchr(path_translated, '\\');
	char slash = '/';
	memcpy(pBack, &slash, 1);

	strcat(txtFile, path_translated);
	strcat(txtFile, script_name);

	char* pForward = strrchr(txtFile, '/');
	char theZoo[] = "/theZoo/";
	memcpy(pForward, theZoo, strlen(theZoo) + 1);

	//validate QUERY_STRING & parse QUERY_STRING
	if (data != NULL)
	{
		strcat(copyData, data);					// copy data to other variable for changes
		char* pAm = strchr(copyData, '&');		// find location of &
		char space = ' ';						// declare variable for space char
		memcpy(pAm, &space, 1);					// change & to ' '
		char* pEq1 = strchr(copyData, '=');		// find location of =
		memcpy(pEq1, &space, 1);				// change = to ' '
		char* pEq2 = strchr(copyData, '=');		// find location of =
		memcpy(pEq2, &space, 1);				// change = to ' '

		int result = sscanf(copyData, "%s %s %s %s", &user, &name, &animals, &animal);
		strcat(txtFile, animal);
		strcat(txtFile, ".txt");
		strcat(imgFile, animal);
		strcat(imgFile, ".jpg");

		//if username has space it appears +, change it to ' ', before display in html
		char* pPlus = strchr((char*)name, '+');
		memcpy(pPlus, &space, 1);

		// a salutation to the user
		printf("<div class=\"container-lg\">\n");
		printf("<h1 class=\"text-bg-info p-3\">Hello %s!   Yes, it's all about animals.</h1>\n", name);
		printf("<table class=\"table\">\n<tr>\n");
		// display server page details with img, txt
		displayServerPage(imgFile, txtFile, animal);
		printf("</tr>\n</table>\n");
		printf("</div>\n");
	}
	else
	{
		printf("<h1>Invalid Data!</h1>");
		return 1;
	}

	printf("</body>\n</html>\n");
	return 0;
}


// Function: displayServerPage()
// Parameters: char* imgFile, char* txtFile, char* animal
// Return Value: nothing
// Description: This function takes char* of imgFile, txtFile, animal and
// print imgFile into HTML format to open the img file and open the text file using fileIO(fopen) and display into HTML format 
void displayServerPage(char* imgFile, char* txtFile, char* animal)
{
	// print html
	printf("<td><img src=\"%s\" alt=\"%s\" width=\"350\"></td>\n", imgFile, animal);
	// HTML formatting txt file
	FILE* ifp = NULL;
	char fileError[] = "File I/O ERROR";
	char txt[1000];

	ifp = fopen(txtFile, "r");
	if (ifp == NULL)
	{
		printf("<td>%s: OPEN</td>\n", fileError);
	}
	else
	{
		printf("<td>");
		while (!feof(ifp))
		{
			fgets(txt, sizeof(txt), ifp);
			printf("%s", txt);
		}
		printf("<td>");

		if (fclose(ifp) != 0)
		{
			printf("<td>%s: CLOSE</td>\n", fileError);
		}
	}

}
