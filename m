Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VTnOu-0003EN-Bc
	for ltp-list@lists.sourceforge.net; Wed, 09 Oct 2013 06:37:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VTnOs-0002l1-M0
	for ltp-list@lists.sourceforge.net; Wed, 09 Oct 2013 06:37:40 +0000
Message-ID: <5254F98A.9080803@cn.fujitsu.com>
Date: Wed, 09 Oct 2013 14:36:58 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <CAB53+CHkXU0qiWwNUkYM0TaZLiAOPgB-cBm7h4tVC7jCS2LKFw@mail.gmail.com>
In-Reply-To: <CAB53+CHkXU0qiWwNUkYM0TaZLiAOPgB-cBm7h4tVC7jCS2LKFw@mail.gmail.com>
Subject: Re: [LTP] [Help] Pushing code to the ltp github
Reply-To: gaowanlong@cn.fujitsu.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Sagar Sakre <sagarsakre@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 10/09/2013 02:27 PM, Sagar Sakre wrote:
> Hi Wanlong
> ,
> 
>     My name is Sagar from india, I am working on ltp since a long time. I have fixed many ltp testcases and now I want to contribute the same to the open source. In ltp github  I am facing some problem while pushing changes. Here is what I did
> 

Welcome!!!

> sagar.sakre@sagar-vm ~/git-hub/ltp/testcases/commands/unzip $ git add unzip_tests.sh
> 
> sagar.sakre@sagar-vm ~/git-hub/ltp $ git commit -s 
> [master 5a4c094] Modified unzip testcase to check for the list of directories unzipped rahter than checking the verbose, because busybox utility in ARM board gives different verbos as inflating than extracting. Signed-off-by: sagar.sakre <sagar.sakre@lge.com <mailto:sagar.sakre@lge.com>>
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> sagar.sakre@sagar-vm ~/git-hub/ltp $ git push
> Username for 'https://github.com': sagarsakre
> Password for 'https://sagarsakre@github.com': 
> error: The requested URL returned error: 403 while accessing https://github.com/linux-test-project/ltp.git/info/refs
> fatal: HTTP request failed
> 
> I may not have permission to push to the repository, Can you please tell me what should I do to solve this issue and continue contributing to the ltp project
> 

You should know that the push permission here is only for maintainers, if everyone can push
to it, the project may be broken ;).
You can make changes on your local git tree and make patches to send to this LTP mail list (ltp-list@lists.sourceforge.net),
we will review your patches, if they are OK, the maintainers will commit your patches
to the upstream LTP tree. 

Thanks,
Wanlong Gao

> -- 
> 
> With Regards,
> Sagar C Sakre


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
