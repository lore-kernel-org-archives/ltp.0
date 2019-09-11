From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Sep 2019 13:19:00 +0200
Subject: [LTP] [PATCH] madvise09:Change PAGES size to the value more
 than 32
In-Reply-To: <CAEemH2fiJkau0A3yQH+nHVPXMwtTzyV3_weTQRniZFR+EJqN_g@mail.gmail.com>
References: <1567576823-10080-1-git-send-email-shuang.qiu@oracle.com>
 <CAEemH2fiJkau0A3yQH+nHVPXMwtTzyV3_weTQRniZFR+EJqN_g@mail.gmail.com>
Message-ID: <20190911111900.GA19244@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm not sure why 64 pages is a proper value? Can you explain more?

I've just talked to Michal Hocko and the conclusion is that we should
allocate several megabytes to avoid depending kernel implementation
details, which would mean allocating thousands of pages.

-- 
Cyril Hrubis
chrubis@suse.cz
