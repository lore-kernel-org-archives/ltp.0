From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 30 Aug 2017 11:24:17 -0400 (EDT)
Subject: [LTP] [PATCH v2 2/2] syscalls/mbind: cleanup and rewrite
 mbind01 into new API
In-Reply-To: <20170830143542.xigsd3b6f4npam6r@x230>
References: <20170829153509.12613-1-pvorel@suse.cz>
 <20170829153509.12613-2-pvorel@suse.cz>
 <4aff45ce-f45f-147d-e9c2-80eca59d74ec@redhat.com>
 <20170830123729.txs276jj5aus7qne@dell5510>
 <740583648.6098356.1504102136816.JavaMail.zimbra@redhat.com>
 <20170830143542.xigsd3b6f4npam6r@x230>
Message-ID: <1243222796.6121570.1504106657531.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> > > I'm ok with all but this one. It's needed for a first case
> > > (POLICY_DESC(MPOL_DEFAULT),),
> > > no mater whether it's first or not. So I didn't put expected_nodemask to
> > > it
> > > in my v3. Or
> > > am I'm missing something.
> 
> > It's not needed, because we compare against "empty_nodemask"
> > in this case. "nodemask" is not used at all. mbind() doesn't use
> > any mask (in test_none()) and numa_bitmask_equal() compares
> > "getnodemask" with "empty_nodemask".
> 
> Thanks for an explanation. Please push it all.

Pushed.

I used a version that adds int cast for 1/2,
no additional changes in 2/2.

Regards,
Jan
