From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Jan 2019 14:12:30 +0100
Subject: [LTP] [PATCH v3 2/6] shell: Add tst_security.sh helper
In-Reply-To: <20181218010220.2446-3-pvorel@suse.cz>
References: <20181218010220.2446-1-pvorel@suse.cz>
 <20181218010220.2446-3-pvorel@suse.cz>
Message-ID: <20190116131230.GC24833@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It prints info about AppArmor and SELinux and allows to disable it.
> This is due some false positives because improper usage or bugs
> in AppArmor profiles (e.g. traceroute, dnsmasq).

Looks good, the only piece I'm not 100% sure about is if this should be
sourced by default in tst_test.sh. Shouldn't we just include this in
network tests?

-- 
Cyril Hrubis
chrubis@suse.cz
