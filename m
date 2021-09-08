From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Sep 2021 16:32:14 +0200
Subject: [LTP] [PATCH] lib: memutils: don't pollute entire system memory
 to avoid OoM
In-Reply-To: <CA+Eumj53j-AucdNdJ91-wHO6CN=jNg=kpNpxNwnRwqvbxsWMkw@mail.gmail.com>
References: <20210624132226.84611-1-krzysztof.kozlowski@canonical.com>
 <YTi8qQOZU3NriZvZ@yuki>
 <3308f9e1-7766-8409-0360-9fe798276a90@suse.cz>
 <YTjGCeaaA0Nv56hn@yuki>
 <CA+Eumj53j-AucdNdJ91-wHO6CN=jNg=kpNpxNwnRwqvbxsWMkw@mail.gmail.com>
Message-ID: <YTjJbnPleZA4wZJb@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Sounds good.
> >
> > Krzysztof unless you disagree I will push your patch but change the
> > division factor from 200 to 64.
> 
> 
> Sounds good. In such case please also update the % mentioned at the
> end of commit msg (0.5% -> 1.5%).

Done and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
