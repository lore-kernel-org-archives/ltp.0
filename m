From: Michal Hocko <mhocko@suse.com>
Date: Tue, 3 Nov 2020 14:22:21 +0100
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <20201021193322.GA300658@carbon.dhcp.thefacebook.com>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
 <20201020162714.GC46039@blackbook>
 <20201020170717.GA153102@carbon.DHCP.thefacebook.com>
 <20201020181822.GA397401@cmpxchg.org>
 <20201021193322.GA300658@carbon.dhcp.thefacebook.com>
Message-ID: <20201103132221.GI21990@dhcp22.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
I am sorry but I was quite busy at the time this has been discussed.
Now that I got to this thread finally I am wondering whether this
resp. other root cgroup exceptions have any follow up.

I have seen the issue is fixed in Linus tree by 8de15e920dc8 ("mm:
memcg: link page counters to root if use_hierarchy is false"). Thanks
for taking care of that! I do agree that this approach is the most
reasonable immediate fix.

Btw. we have been carrying a warning about non hierarchical hierarchies
for years in our distribution kernels and haven't heard of any actual
bug reports (except for LTP driven ones). So we might be really close to
simply drop this functionality completely. This would simplify the code
and prevent from future surprises.

Thanks!
-- 
Michal Hocko
SUSE Labs
