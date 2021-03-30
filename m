From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 30 Mar 2021 15:04:37 +0200
Subject: [LTP] [PATCH] syscalls/chdir: bugfix for
 syscalls/chdir/chdir01.c
In-Reply-To: <20210322091512.103266-1-xieziyao@huawei.com>
References: <20210322091512.103266-1-xieziyao@huawei.com>
Message-ID: <YGMh5b/wj8XjeTqK@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

NOTE, there was already another solution posted before [1].

I slightly prefer this one as it reverts back previous setup, which is a good
habit, but no hard feeling because it's probably not needed in this case.

I wonder what I'm missing, because although I set system umask 222 (in
/etc/pam.d/common-session and verified it's working) I was not able to trigger
any problem.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210317072652.26974-1-zhaogongyi@huawei.com/
