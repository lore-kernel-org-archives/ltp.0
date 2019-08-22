From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 22 Aug 2019 08:37:47 -0400 (EDT)
Subject: [LTP] [PATCH v2] cve: Fix kernel symbol finding for meltdown
 case
In-Reply-To: <145293056.7577705.1566403293117.JavaMail.zimbra@redhat.com>
References: <1566376044-175216-1-git-send-email-zhe.he@windriver.com>
 <145293056.7577705.1566403293117.JavaMail.zimbra@redhat.com>
Message-ID: <1053175586.7790160.1566477467514.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> 
> ----- Original Message -----
> > From: He Zhe <zhe.he@windriver.com>
> > 
> > meltdown case fails as below.
> > safe_file_ops.c:219: BROK: Expected 3 conversions got 2 at meltdown.c:272
> > 
> > find_kernel_symbol is defined to try twice with each of /proc/kallsyms and
> > /boot/System.map-%s. Currently if the symbol is not found in
> > /proc/kallsyms,
> > when kernel option CONFIG_KALLSYMS_ALL is disabled, it would stop the case
> > immediately due to SAFE_FILE_LINES_SCANF.
> > 
> > This patch turns to use FILE_LINES_SCANF to give find_kernel_symbol second
> > chance.
> 
> That explains it, thanks for the patch.
> 
> We should also tweak TCONF condition in find_kernel_symbol - no need
> to re-post for that, I can add that.

Pushed, also with tweak for commit 7709d2ae92ea, so we try System.map,
even if kallsyms are completely disabled.

Regards,
Jan
