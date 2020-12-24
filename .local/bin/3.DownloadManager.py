import sys
from PyQt5.QtWidgets import *
from PyQt5.QtCore import *
import urllib.request
import clipboard

defaultPath = "/home/saad"
class Window(QDialog):
    def __init__(self):
        QDialog.__init__(self)
        self.setWindowTitle("Downloader")
        self.UI()
    def UI(self):
        layout = QVBoxLayout()
        layout1 = QHBoxLayout()
        self.url = QLineEdit()
        self.saveProgress = QLineEdit()
        self.progressBar = QProgressBar()
        download = QPushButton("Download")
        self.btnBrowse = QPushButton("Browse")
        
        layout.addWidget(self.url)
        layout1.addWidget(self.saveProgress)
        layout1.addWidget(self.btnBrowse)
        layout.addLayout(layout1)
        # layout.addWidget(self.saveProgress)
        layout.addWidget(self.progressBar)
        layout.addWidget(download)
        # setting the placeholder
        self.url.setPlaceholderText("Enter the url")
        self.saveProgress.setPlaceholderText("File save location")
        self.setFocus() 
        self.progressBar.setValue(0)
        self.progressBar.setAlignment(Qt.AlignRight)
        self.btnBrowse.clicked.connect(self.setFileLocation)
        
        download.clicked.connect(self.fileDownload)
        url = clipboard.paste()
        if "http://" in url or "https://" in url or "ftp://" in url or "data:image" in url:
            self.url.setText(str(url))
        self.setLayout(layout)
    def setFileLocation(self):
        global defaultPath
        url = str(QFileDialog.getSaveFileName(self,"Save file",defaultPath,"IMAGE(*.png *.jpg);;ALL FILES(*)")[0])
        print(url)
        self.saveProgress.setText(url)

    def fileDownload(self):
        url = self.url.text()
        location = self.saveProgress.text()
        urllib.request.urlretrieve(url,location,self.report)
        QMessageBox.information(self,"Note","Downloaded Successfully")
    def report(self,blockNum,blockSize,totalSize):
        readSoFar = blockNum * blockSize
        if totalSize > 0:
            percentage = readSoFar/totalSize *  100
            self.progressBar.setValue(int(percentage))
def main():
    app=QApplication(sys.argv)
    window=Window()
    window.show()
    sys.exit(app.exec_())
if __name__ == "__main__":
    main()