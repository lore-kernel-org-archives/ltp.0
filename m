From: Davidlohr Bueso <dave@stgolabs.net>
Date: Mon, 14 May 2018 09:19:10 -0700
Subject: [LTP] [PATCH -next 0/2] ipc/shm: shmat() fixes around nil-page
In-Reply-To: <8addf0c1-26cd-add9-fb9c-292cc3567014@suse.cz>
References: <20180503203243.15045-1-dave@stgolabs.net>
 <8addf0c1-26cd-add9-fb9c-292cc3567014@suse.cz>
Message-ID: <20180514161910.gbt32tfsocpddaav@linux-n805>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 10 May 2018, Vlastimil Babka wrote:

>Can you add appropriate Fixes: tags if possible? I guess patch 1 is
>clear, dunno about patch 2...

Right, patch 1 would still benefit from Fixes tag. As to patch 2, the bug
as been there since forever (pre-dates git history). But yeah, as both come
together and are related to a certain extent, the same Fixes could serve both
patches.

Thanks,
Davidlohr
