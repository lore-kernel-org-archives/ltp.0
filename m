From: Zhang, Yixin <yixin.zhang@intel.com>
Date: Thu, 31 May 2018 10:43:24 +0800
Subject: [LTP] [PATCH ltp] network/stress/ssh/ssh-stress01-rmt: fix
 shellcheck error
In-Reply-To: <bc59a0c0-c8e0-c10b-3bee-67672dee145d@oracle.com>
References: <20180525075139.12349-1-yixin.zhang@intel.com>
 <bc59a0c0-c8e0-c10b-3bee-67672dee145d@oracle.com>
Message-ID: <20180531024324.ikx2446ds4f5vodg@yixin-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

Thanks for the comment, a V2 patch is sent.

Yixin

On 2018-05-28 at 17:38:26 +0300, Alexey Kodanev wrote:
> On 05/25/2018 10:51 AM, Yixin Zhang wrote:
> > testcases/network/stress/ssh/ssh-stress01-rmt:57:16: error: Since you
> > double quoted this, it will not word split, and the loop will only run
> > once. [SC2066]
> > 
> 
> Right. Hopefully 'kill' accepts a list of pids.
> 
> > Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> > ---
> >  testcases/network/stress/ssh/ssh-stress01-rmt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/testcases/network/stress/ssh/ssh-stress01-rmt b/testcases/network/stress/ssh/ssh-stress01-rmt
> > index 2a84957ca..3f670a3b8 100644
> > --- a/testcases/network/stress/ssh/ssh-stress01-rmt
> > +++ b/testcases/network/stress/ssh/ssh-stress01-rmt
> > @@ -54,7 +54,7 @@ done
> >  all_conn=$(ps auxw | grep -Fv grep | \
> >  	grep "ssh[[:blank:]].*${ssh_config}" | awk '{print $2}')
> >  
> > -for ssh_pid in "$all_conn"; do
> > +for ssh_pid in $all_conn; do
> >  	kill $ssh_pid
> 
> Could we just add 'kill $all_conn', or use the above pattern with pkill, i.e.
> 
> pkill -f "ssh .*$ssh_config"
> 
> instead of adding $all_conn and the 'for' loop?
