From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 6 May 2020 10:00:09 -0400 (EDT)
Subject: [LTP] [PATCH 1/1] pty04: Fix build for kernel headers < v4.2-rc1
In-Reply-To: <20200506134858.23919-1-pvorel@suse.cz>
References: <20200506134858.23919-1-pvorel@suse.cz>
Message-ID: <1588328084.11511511.1588773609302.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> https://travis-ci.org/github/pevik/ltp/builds/683787204
> 
>  configure.ac                 |  1 +
>  include/lapi/tty.h           | 17 +++++++++++++++++
>  testcases/kernel/pty/pty04.c | 17 ++++++++++-------
>  3 files changed, 28 insertions(+), 7 deletions(-)
>  create mode 100644 include/lapi/tty.h
> 

Works for me (rhel6/7), thanks Petr.

