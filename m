From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Apr 2016 13:30:42 +0800
Subject: [LTP] [PATCH V3] madvice: new case for madvise(WILLNEED)
In-Reply-To: <1459488281-23882-1-git-send-email-liwang@redhat.com>
References: <1459488281-23882-1-git-send-email-liwang@redhat.com>
Message-ID: <CAEemH2ebdk0e3LP=Oof30OMAwXsBc0GiSy6mGSUnWHSZ335o5Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sorry, I missed to append the notes in patch V3.

    V2 --> V3
    * remove the unused <sys/shm.h>
    * reset TST_TOTAL = 1
    * rename variable dst_num to dst_max
    * take use of SAFE_MMAP(), SAFE_MUNMAP()
    * no sleep() in the program
    * fix the lines over 80 chars issue
    * delete the kernel choise lines


-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160401/b91c3aa5/attachment.html>
