From: Li Wang <liwang@redhat.com>
Date: Fri, 15 May 2020 13:52:41 +0800
Subject: [LTP] [PATCH v2 1/4] INSTALL: Update requirements
In-Reply-To: <20200514190906.27130-1-pvorel@suse.cz>
References: <20200514190906.27130-1-pvorel@suse.cz>
Message-ID: <CAEemH2e5G53VPLp4bOe_i-2_4eRSF9dbTC378rqN-AwGanUTEw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

As we know most distributions provide the requirements packages already,
so I'm thinking if we can replace the download link only by installing
commands, that will make people easily prepare their test environment.

Which something maybe likes:
--------------------------------------

+       #### Debian/Ubuntu
+       ```
+       sudo apt-get install make
+       sudo apt-get install pkgconf
+       sudo apt-get install autoconf
+       sudo apt-get install automake
+       sudo apt-get install byacc
+       sudo apt-get install flex
+       sudo apt-get install m4
+       ```
+
+       #### OpenSUSE
+       ```
+       sudo zypper install make
+       sudo zypper install pkgconf
+       sudo zypper install autoconf
+       sudo zypper install automake
+       sudo zypper install byacc
+       sudo zypper install flex
+       sudo zypper install m4
+       ```
+       #### Fedora/CentOS/RHEL
+       ```
+       sudo yum install make
+       sudo yum install pkgconf
+       sudo yum install autoconf
+       sudo yum install automake
+       sudo yum install byacc
+       sudo yum install flex
+       sudo yum install m4
+       ```

Anyway, this is a good update for documents, I hope these could be involved
in the newly released.
[CC Cyril to notice this]

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200515/494ac470/attachment-0001.htm>
