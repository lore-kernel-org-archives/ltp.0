From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 1 Mar 2021 17:04:14 +0100
Subject: [LTP] [PATCH v2 2/6] zram01.sh: Generate test setup variables
 in setup
In-Reply-To: <YDz7WqyTUnTXrnXc@yuki.lan>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-3-pvorel@suse.cz> <YDz7WqyTUnTXrnXc@yuki.lan>
Message-ID: <YD0QftayUp+PNso4@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> Looks good including the changes proposed in the thread.

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks! I suppose this include keep "grep -v -e fat -e ntfs -e fuse"
to avoid fat/ntfs testing (I'd personally use it, because we don't whitelist
testing them for other tests, e.g. fanotify).

Kind regards,
Petr
