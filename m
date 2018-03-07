From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 7 Mar 2018 12:17:59 +0300
Subject: [LTP] [PATCH] network: new regression test for over-sized
 chunks in SCTP
In-Reply-To: <20180306182028.o66mafd52pef7kfz@dell5510>
References: <1520337452-10137-1-git-send-email-alexey.kodanev@oracle.com>
 <20180306182028.o66mafd52pef7kfz@dell5510>
Message-ID: <d07fb068-75ea-fe89-2331-995f6f1f1fbb@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06.03.2018 21:20, Petr Vorel wrote:
>> Fixed by upstream commit 07f2c7ab6f8d ("sctp: verify size of a
>> new chunk in _sctp_make_chunk()")
> 
>> CVE-2018-5803
> I wonder whether to add it also into runtest/cve. But these aren't usually run with
> /opt/ltp/testscripts/network.sh. Don't we want to create something like runtest/cve-network?
> 
> This is one of several tests in runtest/net.features which runs "forever", generating
> impressive load and blocking link making it impossible even to log in.
> Actually I wasn't able to pass it with any of my virtual machines (various distros).
> What is the prerequisite for the test? Separate "safe" link to SUT (not to be affected by
> the test)? It'd be great if the test wasn't too resource demanding.

There is no prerequisite for the test, adding addresses is needed
to construct a big INIT packets that will eventually include
all this variable size parameters, then send it to the server.

We can construct it manually though, it should be much faster.
I'll try to come up with another version.

Thanks,
Alexey
