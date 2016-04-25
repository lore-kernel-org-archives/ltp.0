From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 25 Apr 2016 04:49:37 -0400 (EDT)
Subject: [LTP] [PATCH] open_posix_testsuite: Propagate configure params
In-Reply-To: <20160420162353.GA28307@rei>
References: <20160420162353.GA28307@rei>
Message-ID: <1332064676.4709185.1461574177645.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Wednesday, 20 April, 2016 6:23:53 PM
> Subject: [LTP] [PATCH] open_posix_testsuite: Propagate configure params
> 
> The open_posix_testsuite can be enabled to build from the top level
> configure but none of the parameters passed to it are propagated which
> confuses users and has been discussed a few times on the LTP ML.
> 
> This commit propagates CC, CFLAGS and LDFLAGS. If config-openposix.mk
> was created by the top level configure script the generate-makefiles.sh
> script includes its content in the generated Makefiles.
> 
> This fixes issue #54.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Jan Stancek <jstancek@redhat.com>

Looks good to me.

Regards,
Jan
