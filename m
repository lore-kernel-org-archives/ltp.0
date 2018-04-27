From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 27 Apr 2018 13:37:07 +0200
Subject: [LTP] [PATCH] commands: Remove all test cases
In-Reply-To: <20180427113553.GA14075@rei>
References: <20180426132418.19495-1-schlad@suse.de>
 <20180426132418.19495-2-schlad@suse.de>
 <b72b277b-e8e0-d69c-b918-bd48341c2a1d@oracle.com>
 <20180426172713.GB14157@x230> <20180427113553.GA14075@rei>
Message-ID: <20180427113706.GB14075@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It's really hard to draw a line here, but I would probably vote for
> keeping tests that are working with files such as cp/df/ln/wc as these
                                                             ^
							     This
							     shouldn't
							     be
							     obviously
							     here...

-- 
Cyril Hrubis
chrubis@suse.cz
