From: vishnu <vishnu@zilogic.com>
Date: Tue, 31 Jul 2018 09:27:48 -0000
Subject: [LTP] [PATCH v3] Test for memfd_create() syscall
	withMFD_HUGETLBflag.
References: <20180727135320.6590-1-vishnu@zilogic.com>
 <1256447007.36783029.1532959840507.JavaMail.zimbra@redhat.com>
Message-ID: <4504bc463448837a2489d78d43a19f49.squirrel@pike.zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

Thanks for your code review. We will make the changes in next patch.

In set-up(), we are using SAFE_FILE_LINES_SCANF(). Do we need to go
for FILE_LINES_SCANF() with tst_brk-> TCONF on error?

Regards,
Vishnu K

