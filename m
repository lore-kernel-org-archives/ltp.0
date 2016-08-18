From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Aug 2016 11:19:31 +0200
Subject: [LTP] [PATCH 2/8] waitpid10: use the new API
In-Reply-To: <57B572BD.9040508@oracle.com>
References: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160815143602.GF20680@rei.lan> <57B57102.1010305@oracle.com>
 <57B572BD.9040508@oracle.com>
Message-ID: <20160818091931.GB20169@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > waitpid_test() just forks a child - do_child_1() which then does the
> > actual testing. This scheme is needed in other test cases, since they
> > operate with process groups.
> > 
> > Yes, here it's redundant, since this do_child_1() doesn't touch process
> > groups. I decided to use this scheme here just for similarity with other
> > test cases. In my opinion, it brings no harm or improvements.
> 
> I can add this to the commit message.

Ok

-- 
Cyril Hrubis
chrubis@suse.cz
