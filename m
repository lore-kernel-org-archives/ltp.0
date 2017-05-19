From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 May 2017 15:06:16 +0200
Subject: [LTP] [PATCH 05/10] Add CVE .gitignore,
 Makefile and runtest files
In-Reply-To: <20170519123156.8462-5-rpalethorpe@suse.com>
References: <20170519123156.8462-1-rpalethorpe@suse.com>
 <20170519123156.8462-5-rpalethorpe@suse.com>
Message-ID: <20170519130616.GC17258@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +CFLAGS			+= -D_GNU_SOURCE
> +
> +<<<<<<< HEAD
> +cve-2016-7117:	LDFLAGS += -lpthread
> +=======
> +cve-2014-0196:	LDFLAGS += -lpthread -lutil -lrt
> +cve-2016-7117:	LDFLAGS += -lpthread -lrt
> +>>>>>>> 4dbfb8e79... Add -lrt

Unsolved merge conflict here and in the next file.

-- 
Cyril Hrubis
chrubis@suse.cz
