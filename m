From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Apr 2021 14:45:11 +0200
Subject: [LTP] [PATCH v3 5/7] fzsync: Move yield check out of loop and
 add yield to delay
In-Reply-To: <20210319091837.27319-6-rpalethorpe@suse.com>
References: <20210319091837.27319-1-rpalethorpe@suse.com>
 <20210319091837.27319-6-rpalethorpe@suse.com>
Message-ID: <YG7618K/Iy4KgDRw@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The two patches that add the yield_in_wait() looks good.

The first one has some style issues, but that is fixed with the second
one. Also I guess that we can merge these two and add both
signed-off-by, but I do not care that much about this.

Anyways Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
