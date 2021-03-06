// AVI MetaEdit GUI - A GUI for AVI MetaEdit
//
// This code was created in 2010 for the Library of Congress and the
// other federal government agencies participating in the Federal Agencies
// Digitization Guidelines Initiative and it is in the public domain.
//
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------------------------------
#ifndef GUI_Main_xxxx_BextH
#define GUI_Main_xxxx_BextH
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
class Core;
#include <QtGui/QDialog>
class QDialogButtonBox;
class QComboBox;
//---------------------------------------------------------------------------

//***************************************************************************
// GUI_Main_xxxx_Bext
//***************************************************************************

class GUI_Main_xxxx_Bext : public QDialog
{
    Q_OBJECT

public:   
    //Constructor/Destructor
    GUI_Main_xxxx_Bext(Core* C, const std::string &FileName_, QWidget* parent=NULL);

    //Widgets
    QComboBox*          Extra_Bext_DefaultVersion;
    QDialogButtonBox*   Dialog;

private slots:
    //Actions
    void OnAccept                   ();

private:
    //Internal
    Core* C;
    std::string FileName;
};

#endif
