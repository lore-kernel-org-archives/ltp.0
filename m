From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 May 2021 13:36:34 +0200
Subject: [LTP] [PATCH] realtime/func/pi-tests: testpi-2 parser
 indentation fix
In-Reply-To: <1620029239-31643-1-git-send-email-ankitja@vmware.com>
References: <1620029239-31643-1-git-send-email-ankitja@vmware.com>
Message-ID: <YI/gQjOJK3dtjiPr@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ankit,

> There is an indentation issue in parser for testpi-2
> which causes incorect parsing of the logs.

Thanks for your fix, merged!

FYI the patch didn't apply, not sure why, I had to use patch to apply it
(instead of git am). I guess it was wrongly generated, please make sure
you use git format-patch properly.

If pi-tests are really working and worth to keep (one of my colleagues
realtime expert in the past didn't see much value in them), it'd be good
to rewrite these parsers to shell (to avoid unnecessary python3 dependency).

https://github.com/linux-test-project/ltp/issues/547

Also script assign True to flag variable but never uses it.

Kind regards,
Petr
