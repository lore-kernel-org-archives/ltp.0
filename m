From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Mar 2016 14:17:50 +0100
Subject: [LTP] [PATCH 3/4] mm/ksm: moving the merge_across_nodes
 statement in mem.h
In-Reply-To: <1457602468-24268-3-git-send-email-liwang@redhat.com>
References: <1457602468-24268-1-git-send-email-liwang@redhat.com>
 <1457602468-24268-2-git-send-email-liwang@redhat.com>
 <1457602468-24268-3-git-send-email-liwang@redhat.com>
Message-ID: <20160322131750.GB10905@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The mem.c take use of this value, so that would be better to declear
> it in mem.h.

No it does not. If you grep lib/mem.c the only place where this name
appears is inside of a string and comment.

-- 
Cyril Hrubis
chrubis@suse.cz
