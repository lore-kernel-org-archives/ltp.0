Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QgIzV-000425-IW
	for ltp-list@lists.sourceforge.net; Mon, 11 Jul 2011 16:05:49 +0000
Date: Mon, 11 Jul 2011 18:07:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110711160709.GA31575@saboteur.suse.cz>
References: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
	<1309414787-2022-2-git-send-email-yanpai.chen@gmail.com>
	<20110711144528.GE26246@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110711144528.GE26246@saboteur.suse.cz>
Subject: Re: [LTP] [PATCH 2/7] testcases: cgroup: correct wrong variable
 used in the testscript
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
To: Andrew Chen <yanpai.chen@gmail.com>
Cc: ltp-list@lists.sourceforge.net, ypchen@faraday-tech.com

Hi!
> > From: Andrew Chen <ypchen@faraday-tech.com>
> > 
> > 
> > Signed-off-by: Andrew Chen <ypchen@faraday-tech.com>
> > ---
> >  .../controllers/cgroup/cgroup_regression_test.sh   |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/ltp-full-20101031/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/ltp-full-20101031/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> > index 5527afc..c7ce791 100755
> > --- a/ltp-full-20101031/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> > +++ b/ltp-full-20101031/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> > @@ -254,7 +254,7 @@ test_5()
> >  	subsys1=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
> >  	subsys2=`tail -n 2 /proc/cgroups | head -1 | awk '{ print $1 }'`
> >  
> > -	mount -t cgroup -o $subsys1,$subsys xxx cgroup/
> > +	mount -t cgroup -o $subsys1,$subsys2 xxx cgroup/
> >  	if [ $? -ne 0 ]; then
> >  		tst_resm TFAIL "mount $subsys1 and $subsys2 failed"
> >  		failed=1
> > -- 
> 
> Please don't leave the commit messages empty, even for such change it
> should be something like:
> 
> "Fix typo in cgroup_regression_test.sh."

Argh, scratch that. I'm allways confused by git generated emails.

I would certainly expect that they add the first line of commit message
not only to subject but into the mail body as well.

Anyway the patches won't apply as they have ltp-full-20101031 prefix in
the path and 'git am' couldn't find the files.

PS: It's better to work with the LTP git repository to be sure you are
    not fixing fixed problem.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
