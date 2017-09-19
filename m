From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Sep 2017 01:34:58 +0200
Subject: [LTP] [PATCH 1/1] network/stress: Fix and cleanup part of
 multicast group tests
In-Reply-To: <20170911210835.25381-1-pvorel@suse.cz>
References: <20170911210835.25381-1-pvorel@suse.cz>
Message-ID: <20170919233457.cpcmegrg5mkkyypp@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> * Fix test for SSH and netns based testing.
> * Remove hardcoded rsh dependency.
> * Create shell library mcast-lib.sh (multicast specific) to reduce
> duplicity in tests. Library uses test_stress_net.sh (and therefore
> test_net.sh).
> * Merged IPv4 and IPv6 tests into one file.
> * Renamed test names and files (readability).
> * Cleanup code + fixed typos.

Any chance to merge this before release?


Kind regards,
Petr
