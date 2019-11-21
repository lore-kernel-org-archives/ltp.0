From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 21 Nov 2019 04:01:15 -0500 (EST)
Subject: [LTP] [PATCH v4 1/5] syscalls/quotactl01: Add Q_GETNEXTQUOTA
 test
In-Reply-To: <20191120151244.GA28197@dell5510>
References: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1574241216-15168-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191120151244.GA28197@dell5510>
Message-ID: <1893160007.13287158.1574326875945.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> @Jan, @Cyril: Do we want to generally avoid loading <linux/types.h> if not
> really needed?

Yes, we generally try to avoid including kernel headers. Our style-guide says
"Don't use +linux/+ headers if at all possible". uapi on older distros
was more prone to cause LTP build errors.

