From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 22 Nov 2016 13:35:39 +0300
Subject: [LTP] [PATCH][RFC] network: test_net.sh: allow to run tests on
 a single machine
In-Reply-To: <20161122083841.GA7048@rei.lan>
References: <1479130404-31787-1-git-send-email-alexey.kodanev@oracle.com>
 <20161122083841.GA7048@rei.lan>
Message-ID: <58341F7B.8040108@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 11/22/2016 11:38 AM, Cyril Hrubis wrote:
> Hi!
>> When 'TST_USE_NETNS' environment variable is defined, test_net.sh
>> will setup 'ltp_ns' netns and configure veth pair according to
>> other LTP network variables. Then, each tst_rhost_run() call will
>> be executed in the new netns on the same host.
>>
>> Usage:
>> TST_USE_NETNS=1... ./network.sh -i
> Looks like a smart idea to me, the implementation looks ok as well. I
> wonder if we should add these kind of network tests into default
> scenario...

Some test groups can be added and I guess we should default to netns 
configuration
if RHOST variable isn't defined. This way the tests won't require any 
network
environment variables set beforehand.

> The patch misses any documentation though, it should be described
> properly somewhere.

Right, will add it and send a new version.


Thanks,
Alexey

