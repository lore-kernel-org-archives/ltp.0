From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Apr 2018 11:21:52 +0200
Subject: [LTP] Errored: linux-test-project/ltp#758 (master - 06ee2b0)
In-Reply-To: <20180418061152.i44g47utzldyw7lc@dell5510>
References: <linux-test-project/ltp+367800244+errored@travis-ci.org>
 <5ad64480951dd_43f9e19419460435637@6c41ee02-ea54-406b-b1d2-cd774a36365b.mail>
 <20180418061152.i44g47utzldyw7lc@dell5510>
Message-ID: <20180418092152.GA4266@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> False positive, again. This time it's due failing to install Java
> (oracle-java8-installer and oracle-java9-installer).
> I delete these repositories.

I wonder if we can do something as disable everything but the base
repositories + the few we actually need...

-- 
Cyril Hrubis
chrubis@suse.cz
