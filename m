From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 15 Apr 2019 15:49:37 +0200
Subject: [LTP] [PATCH v1] Fix build error caused by
 -Werror-implicit-function-declaration for Android
In-Reply-To: <1554992323-14338-1-git-send-email-ruanzw@xiaopeng.com>
References: <1554992323-14338-1-git-send-email-ruanzw@xiaopeng.com>
Message-ID: <20190415134937.GA8625@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> Fix build errors caused by -Werror-implicit-function-declaration by add missing
> <string.h> and <strings.h> for Android.

> Signed-off-by: Zhengwang Ruan <ruanzw@xiaopeng.com>
In the end merged this one (after rebase), which fixes android build for now and
added a ticket for replacing deprecated functions from <strings.h>

https://github.com/linux-test-project/ltp/issues/521

Zhengwang, thanks for your work and testing.

Kind regards,
Petr
