From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Sep 2021 15:32:16 +0200
Subject: [LTP] [PATCH v2 5/5] syscalls/setregid02-04: Eliminate named
 group lookups
In-Reply-To: <20210907113222.5156-5-mdoucha@suse.cz>
References: <20210907113222.5156-1-mdoucha@suse.cz>
 <20210907113222.5156-5-mdoucha@suse.cz>
Message-ID: <YTdp4MfjExppWLpy@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I did a minor change to the setregid03 and pushed, good work, thanks.

There was no reason to copy the struct passwd for nobody into a global
variable in the setup() so I've removed that part as well.

-- 
Cyril Hrubis
chrubis@suse.cz
