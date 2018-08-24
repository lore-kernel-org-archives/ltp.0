From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 24 Aug 2018 04:34:08 -0400 (EDT)
Subject: [LTP] [PATCH] fs/ftest/ftest06.c: Fix too small name string
	and	related failure
In-Reply-To: <20180824014624.26667-1-zhe.he@windriver.com>
References: <20180824014624.26667-1-zhe.he@windriver.com>
Message-ID: <91481629.42296391.1535099648037.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The name string is too small to contain normal full path names and causes
> the following failure.
> 
> "ftest06     2  TFAIL  :  ftest06.c:223: Can't chdir(): errno=ENOENT(2): No
> such file or directory"
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>

Pushed.

Thanks,
Jan
