From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 May 2021 16:05:01 +0200
Subject: [LTP] [PATCH v3 1/1] netns_netlink: Rewrite into new API
In-Reply-To: <YJp9/JHow8g5Xt/K@yuki>
References: <20210511125606.20425-1-pvorel@suse.cz>
 <YJp9/JHow8g5Xt/K@yuki>
Message-ID: <YJqPDb5WGhNTtLfB@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> Looks good: Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Thanks!

> Also this is a bugfix for new iproute, right? If so this should get in
> before the release.
Yes, thus pushed.

> And we should probably make use of the netlink library from Martin later
> on, but that can wait after the release.
+1, put into my TODO list.

Also how about keeping libmnl vs. using Martin's library for
route-change-netlink.c? Which one is better to use?
(already asked in [1]: it'd be nice to get rid of libmnl dependency,
but on the other hand using it means also testing it).

Kind regards,
Petr

[1] https://lists.linux.it/pipermail/ltp/2021-May/022529.html
