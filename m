Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YNjx9-0002k4-9B
	for ltp-list@lists.sourceforge.net; Tue, 17 Feb 2015 15:20:47 +0000
Date: Tue, 17 Feb 2015 16:20:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150217152034.GA26897@rei>
References: <789026778.7588485.1423581396876.JavaMail.zimbra@redhat.com>
	<1688764619.7589818.1423581433749.JavaMail.zimbra@redhat.com>
	<20150212110310.GA14329@rei>
	<980241572.9316983.1423749665613.JavaMail.zimbra@redhat.com>
	<54E33EE9.9000302@redhat.com> <20150217140458.GA25756@rei>
	<54E35175.20807@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54E35175.20807@redhat.com>
Subject: Re: [LTP] network namespaces tests cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> $ ip netns add testns
> 
> and the following two have to return different IDs:
> 
> $ readlink /proc/self/ns/net
> net:[4026531969]
> 
> $ ip netns exec testns readlink /proc/self/ns/net
> net:[4026532368]
> 
> (And the kernel tests would ideally ensure that different procfs/ns
>  values *really* result in different namespaces based on tested
>  behavior.)

That sounds reasonable and easy enough.

> > Agree that the kernel functionality is the same. But how does having two
> > different testcases one for kernel functionality and one for ip decrease
> > maintenance ratio? This soulution would IMHO be more complicated. The
> > coverate should be same. The only aspect in which this solution is
> > likely better is test runtime, but that shouldn't be a problem because
> > these testcases does not take long time. Or am I mistaken?
> 
> Right now, they don't (IIRC), but will you document it? Will you watch
> for future tests added to this area, to make sure they don't take a long
> time because of this "hack"? I guess these are the maintenance costs
> I'm trying to point out.

This sounds reasonable as well.

> In the end, my suggestion was really just a suggestion - each approach
> has pros and cons and it's up to the author (and you, as an upstream
> maintainer) to pick the one you want.

And I'm certainly willing to listen to anybody with good ideas ;).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
