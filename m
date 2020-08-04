From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 04 Aug 2020 14:15:50 +0200
Subject: [LTP] looking for a test library home
Message-ID: <8cf945033b519ac7240e42d29906d0d4ed3ed292.camel@sipsolutions.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

After mentioning this on IRC a few days ago, metan suggested I take it
to the list.

Some time ago, I upstreamed "time-travel" and "time-travel=infcpu" modes
for UML (User Mode Linux) which allows time inside to run faster than
real time, and in the =infcpu case completely disconnected from real
time.

Later, I extended this
 1) a combined mode where more than one application can take part in the
    same time simulation; the protocol for this is defined in Linux but
    this mode requires a controller program;
 2) an extension of this to virtio/vhost-user devices.

For 1), the controller program isn't available yet; it's part of my
library/framework. For 2) you need a special vhost-user device-side
implementation due to synchronisation etc., libvhost-user from qemu has
focus on performance and migration and isn't really usable. This is also
part of the framework.

Since we're using this framework to run mostly real firmware code
against real driver code (modified to use virtio instead of pcie) and
also use this framework for unit tests on the device side, there's a
more code in there for making that easy etc.

Consequently, this thing is called the "User Space Firmware
Simulation/Testing Library".

For ... reasons, I can neither put it on my personal github nor on
Intel's, so I'm looking for a good home to have a repository at, and LTP
was suggested as a perhaps fitting location.

What do you think? Ultimately, I think that would simply mean creating
the github.com/linux-test-project/usfstl repository and I could
contribute the code to there in some way, perhaps by sending email
patches, or pull requests, or being maintainer there myself, whichever
you feel is appropriate.

Thanks,
johannes



