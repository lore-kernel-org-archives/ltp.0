From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 28 Feb 2018 12:49:28 +0300
Subject: [LTP] [error] report a fail about udp4_ipsec_vti*
In-Reply-To: <85fed43e-5f7c-f2c3-3f00-b7e4cf9d6f1f@cn.fujitsu.com>
References: <85fed43e-5f7c-f2c3-3f00-b7e4cf9d6f1f@cn.fujitsu.com>
Message-ID: <c1004b23-bbdd-2fac-f047-d0f5c74940b6@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 27.02.2018 09:47, sunlianwen wrote:
> Hi Alexey
> 
>    I run udp4[6]_ipsec_vti always fail. when client /server message size is 65463
> 
> then timeout will happen. I try to modify the client/server message size then run
> 
> this case and find the size is less than 1428 the case running is ok.  But I do not know
> 
> why the threshold size is 1428.  can you  tell me the reason of this failure.
> 
> the test log is below:                            
> 

There is either something wrong with MTU settings for vti and
lower device or UDP fragmentation. You can skip test cleanup
by running it with TST_NO_CLEANUP=yes environment variable set.

Have you tried running it with the latest kernel?

Thanks,
Alexey
