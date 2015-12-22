From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 22 Dec 2015 09:24:59 -0500 (EST)
Subject: [LTP] [PATCH v4] hugetlb/hugemmap: add new testcase hugemmap06.c
In-Reply-To: <1450696613-6847-1-git-send-email-liwang@redhat.com>
References: <1450696613-6847-1-git-send-email-liwang@redhat.com>
Message-ID: <401677023.828855.1450794299787.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: jstancek@redhat.com
> Cc: ltp@lists.linux.it
> Sent: Monday, 21 December, 2015 12:16:53 PM
> Subject: [PATCH v4] hugetlb/hugemmap: add new testcase hugemmap06.c

Pushed with added include for lapi/mmap.h and check for kernel < 2.6.32,
to avoid compilation failure on older distros (e.g. RHEL5.6)

Regards,
Jan
