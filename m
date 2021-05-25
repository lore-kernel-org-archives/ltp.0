From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 25 May 2021 14:13:06 +0200
Subject: [LTP] [RFC PATCH 0/4] Auto review and Coccinelle
In-Reply-To: <20210524144745.10887-1-rpalethorpe@suse.com>
References: <20210524144745.10887-1-rpalethorpe@suse.com>
Message-ID: <YKzp0rxGfaxL1blw@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm not sure how to integrate it with the build system. We may just
> want to do something similar to the kernel. Also I guess we want to
> have a way of checking patches sent to the mailing list.

I guess that having it in travis as a post commit check would be better
than nothing.

Pre commit hook would be ideal but requiring coccinelle installed for
LTP development would increase the bar for contribution too much I
guess.

-- 
Cyril Hrubis
chrubis@suse.cz
