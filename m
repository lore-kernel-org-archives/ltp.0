From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 14 Nov 2016 07:17:46 -0500 (EST)
Subject: [LTP] [RFC] [PATCH] doc: Remove doc/testcases/*
In-Reply-To: <20161110094334.GA11676@rei.lan>
References: <20161110094334.GA11676@rei.lan>
Message-ID: <2065515236.2077378.1479125866081.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Thursday, 10 November, 2016 10:43:34 AM
> Subject: [LTP] [RFC] [PATCH] doc: Remove doc/testcases/*
> 
> These files are not maintained anymore and does not seem to be parsed by
> any tool in the LTP tree. So unless somebody really needs these and is
> willing to maintain them I'm voting for removal.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  doc/testcases/commands.txt             |  170 -
>  doc/testcases/kernel.txt               | 7006
>  --------------------------------
>  doc/testcases/misc.txt                 |  123 -
>  doc/testcases/network.txt              |  570 ---
>  doc/testcases/open_hpi_testsuite.txt   |    5 -
>  doc/testcases/open_posix_testsuite.txt |    5 -
>  6 files changed, 7879 deletions(-)
>  delete mode 100644 doc/testcases/commands.txt
>  delete mode 100644 doc/testcases/kernel.txt
>  delete mode 100644 doc/testcases/misc.txt
>  delete mode 100644 doc/testcases/network.txt
>  delete mode 100644 doc/testcases/open_hpi_testsuite.txt
>  delete mode 100644 doc/testcases/open_posix_testsuite.txt
> 

No objections to removal. I suspect many of these descriptions
are repeated in testcases (which are more up to date).

Regards,
Jan
