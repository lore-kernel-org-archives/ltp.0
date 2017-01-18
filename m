From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Jan 2017 09:31:00 +0100
Subject: [LTP] FYI: networking: broken multicast test due upstream bug
Message-ID: <20170118083100.myaindbkf2nsoqp2@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

mc_cmds test (runtest net.multicast, LTP networking) is broken when running with network
namespaces due upstream bug in ip (see https://bugzilla.kernel.org/show_bug.cgi?id=192741).
In our case 'ip maddr show ltp_ns_veth2' does not return 'inet  224.0.0.1'.

It has been fixed in master, but it will not work with old distros. I suppose we leave it as it is (don't fix it with any workaround).


Kind regards,
Petr
