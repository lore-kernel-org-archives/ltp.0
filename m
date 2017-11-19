From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun, 19 Nov 2017 12:20:51 +0100
Subject: [LTP] Towards 4.14 LTS
In-Reply-To: <5E1947BC-9D22-42EB-BA29-96EA15A9C817@linaro.org>
References: <5E1947BC-9D22-42EB-BA29-96EA15A9C817@linaro.org>
Message-ID: <20171119112051.GA10015@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Thu, Nov 16, 2017 at 10:50:23PM -0600, Tom Gall wrote:
> At Linaro we’ve been putting effort into regularly running kernel tests over 
> arm, arm64 and x86_64 targets. On those targets we’re running mainline, -next, 
> 4.4, and 4.9 kernels and yes we are adding to this list as the hardware 
> capacity grows.
> 
> For test buckets we’re using just LTP, kselftest and libhugetlbfs and
> like kernels we will add to this list. 

I'm sorry, I don't understand this sentance.

> With the 4.14 cycle being a little ‘different’ in so much as the goal to 
> have it be an LTS kernel I think it’s important to take a look at some 
> 4.14 test results. 
> 
> Grab a beverage, this is a bit of a long post. But quick summery 4.14 as 
> released looks just as good as 4.13, for the test buckets I named above.

Thanks for doing this testing and letting us know.

greg k-h
