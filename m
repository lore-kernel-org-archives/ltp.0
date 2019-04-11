From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Apr 2019 01:33:30 +0200
Subject: [LTP] [PATCH v1] Fix build error caused by
 -Werror-implicit-function-declaration for Android
In-Reply-To: <1554992323-14338-1-git-send-email-ruanzw@xiaopeng.com>
References: <1554992323-14338-1-git-send-email-ruanzw@xiaopeng.com>
Message-ID: <20190411233330.GA381@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Fix build errors caused by -Werror-implicit-function-declaration by add missing
> <string.h> and <strings.h> for Android.

> Signed-off-by: Zhengwang Ruan <ruanzw@xiaopeng.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Petr Vorel <pvorel@suse.cz>

See also
http://lists.linux.it/pipermail/ltp/2019-April/011655.html

Kind regards,
Petr
