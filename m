From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Apr 2020 14:34:58 +0200
Subject: [LTP] [PATCH v2] Add test for CVE 2018-18559
In-Reply-To: <20200406153759.2832-1-mdoucha@suse.cz>
References: <20200406153759.2832-1-mdoucha@suse.cz>
Message-ID: <20200408123458.GA7369@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  bind04 bind05:	CFLAGS		+= -pthread
> +bind06:		LDFLAGS		+= -pthread -lrt

I've fixed this part.

The -lfoo has to go to LDLIBS and the -pthread should go to CFLAGS.
Having -lfoo in LDFLAGS tends to cause compilation failures in some
cases because the order of these matters.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
