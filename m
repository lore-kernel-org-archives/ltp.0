From: Tom Gall <tom.gall@linaro.org>
Date: Mon, 20 Nov 2017 10:23:33 -0600
Subject: [LTP] Towards 4.14 LTS
In-Reply-To: <20171119112051.GA10015@kroah.com>
References: <5E1947BC-9D22-42EB-BA29-96EA15A9C817@linaro.org>
 <20171119112051.GA10015@kroah.com>
Message-ID: <EF258C71-3F2A-449C-8283-EA4F715C81C0@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it


> On Nov 19, 2017, at 5:20 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> On Thu, Nov 16, 2017 at 10:50:23PM -0600, Tom Gall wrote:
>> At Linaro we’ve been putting effort into regularly running kernel tests over 
>> arm, arm64 and x86_64 targets. On those targets we’re running mainline, -next, 
>> 4.4, and 4.9 kernels and yes we are adding to this list as the hardware 
>> capacity grows.
>> 
>> For test buckets we’re using just LTP, kselftest and libhugetlbfs and
>> like kernels we will add to this list. 
> 
> I'm sorry, I don't understand this sentance.

I was just saying that we intend to add more test buckets and more kernels.

For instance 4.13-rc just was added to the mix.

For test buckets, I’m currently dorking around with some make check targets
for a few interesting packages. 

> 
>> With the 4.14 cycle being a little ‘different’ in so much as the goal to 
>> have it be an LTS kernel I think it’s important to take a look at some 
>> 4.14 test results. 
>> 
>> Grab a beverage, this is a bit of a long post. But quick summery 4.14 as 
>> released looks just as good as 4.13, for the test buckets I named above.
> 
> Thanks for doing this testing and letting us know.
> 
> greg k-h

