From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Mar 2020 12:18:03 +0100
Subject: [LTP] [PATCH v4 3/3] Add connection tests for bind()
In-Reply-To: <5cf7a3b1-1b34-d10c-5c93-e77ef77f3044@suse.cz>
References: <20200317121057.13529-1-mdoucha@suse.cz>
 <20200317121057.13529-3-mdoucha@suse.cz>
 <20200320085427.GA14750@dell5510>
 <5cf7a3b1-1b34-d10c-5c93-e77ef77f3044@suse.cz>
Message-ID: <20200320111803.GA2935@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> tst_init_sockaddr_inet6() was trivial to implement so it's there for
> future use. The only reason why I'm not using it is that both loopback
> and wildcard addresses are provided by libc in expanded form so I don't
> need to convert them from string. I'll leave this patch as is.
Understand. My concern was that using it there would be more test coverage,
but actually it wouldn't. I'm ok to merge it as it is, just remove IPV6_ADDRESS,
which you don't use.

Kind regards,
Petr
