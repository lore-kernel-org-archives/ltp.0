From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 May 2021 14:52:12 +0200
Subject: [LTP] [PATCH v3 1/1] netns_netlink: Rewrite into new API
In-Reply-To: <20210511125606.20425-1-pvorel@suse.cz>
References: <20210511125606.20425-1-pvorel@suse.cz>
Message-ID: <YJp9/JHow8g5Xt/K@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looks good: Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Also this is a bugfix for new iproute, right? If so this should get in
before the release.

And we should probably make use of the netlink library from Martin later
on, but that can wait after the release.

-- 
Cyril Hrubis
chrubis@suse.cz
