From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 15 Oct 2018 19:03:39 +0300
Subject: [LTP] [PATCH] network/nfs: support default setup,
	use local mount
In-Reply-To: <20181012161325.GA29781@dell5510>
References: <1539091079-21887-1-git-send-email-alexey.kodanev@oracle.com>
 <20181012161325.GA29781@dell5510>
Message-ID: <11a7fe7e-7aa7-1fc9-faa0-81a23855e6d5@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/12/2018 07:13 PM, Petr Vorel wrote:
> Hi Alexey,
> 
>> For default setup, start the server locally instead and mount
>> inside netns to run NFS traffic over the veth or whatever is
>> used for a single machine setup.
> 
>> We could also use lo interface, we just need to skip the last
>> check in nfs_mount()/nfs_lib.sh.
> 
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Acked-by: Petr Vorel <pvorel@suse.cz>
> 
> LGTM, thanks for the patch!
> 

Applied, thanks for review Petr!

> BTW how about split runtest/net.nfs, so it takes shorter to run?
> Maybe it takes so long on my side as I still experience some problems with NFS,
> which I haven't debugged yet (timeout).

Perhaps some default parameters are unreasonably large, e.g. DIR_NUM, FILE_NUM,
THREAD_NUM (nfs03, nfs05 tests)...
