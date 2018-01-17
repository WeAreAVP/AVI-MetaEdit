// AVI MetaEdit GUI - A GUI for AVI MetaEdit
//
// This code was created in 2010 for the Library of Congress and the
// other federal government agencies participating in the Federal Agencies
// Digitization Guidelines Initiative and it is in the public domain.
//
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#include <QApplication>
#ifdef __BORLANDC__
    #pragma hdrstop
#endif
#include "GUI/Qt/App.h"
#include "GUI/Qt/GUI_Main.h"
#include "Common/Core.h"
#include <vector>
#include <iostream>
using namespace std;

#if defined(_WIN32) && !defined(_DLL)
    #include <QtPlugin>
    Q_IMPORT_PLUGIN(QWindowsIntegrationPlugin)
#endif

int main (int argc, char** argv)
{
    QApplication App(argc, argv);
    Core C;
    C.Errors_Continue=true; //Always for the GUI

    GUI_Main Window(&C);
    Window.show();
    int ToReturn=App.exec();

    return ToReturn;
}
