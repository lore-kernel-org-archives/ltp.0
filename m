From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 31 Aug 2017 07:06:07 +0200
Subject: [LTP] [PATCH v2 2/2] syscalls/mbind: cleanup and rewrite
 mbind01 into new API
In-Reply-To: <1243222796.6121570.1504106657531.JavaMail.zimbra@redhat.com>
References: <20170829153509.12613-1-pvorel@suse.cz>
 <20170829153509.12613-2-pvorel@suse.cz>
 <4aff45ce-f45f-147d-e9c2-80eca59d74ec@redhat.com>
 <20170830123729.txs276jj5aus7qne@dell5510>
 <740583648.6098356.1504102136816.JavaMail.zimbra@redhat.com>
 <20170830143542.xigsd3b6f4npam6r@x230>
 <1243222796.6121570.1504106657531.JavaMail.zimbra@redhat.com>
Message-ID: <20170831050607.4abeno7mgahllw75@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> Pushed.

> I used a version that adds int cast for 1/2,
> no additional changes in 2/2.
Thanks for finishing my work. I'll try not to leave silly mistakes next time.

I might add safe macros/functions for some of NUMA functions (is_numa(), numa_available(),
mbind(), get_mempolicy() are candidates).

Kind regards,
Petr
