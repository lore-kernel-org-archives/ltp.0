From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Nov 2017 16:17:03 +0100
Subject: [LTP] [RFC PATCH 2/4] lapi/socket.h: Move definitions from
	netstress.c
In-Reply-To: <20171109113947.24609-3-pvorel@suse.cz>
References: <20171109113947.24609-1-pvorel@suse.cz>
 <20171109113947.24609-3-pvorel@suse.cz>
Message-ID: <20171109151703.GB30136@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  #ifndef SOCK_CLOEXEC
> -# define SOCK_CLOEXEC 02000000
> +#define SOCK_CLOEXEC 02000000
> +#endif

FYI the prefered way how to indent innner macros are spaces after the
hash #.

-- 
Cyril Hrubis
chrubis@suse.cz
