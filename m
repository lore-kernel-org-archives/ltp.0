From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 24 Apr 2018 14:13:19 +0300
Subject: [LTP] [PATCH 2/2] sctp_big_chunk: make INIT packet in the test
In-Reply-To: <5ADF0183.5080208@cn.fujitsu.com>
References: <1524562426-13008-1-git-send-email-alexey.kodanev@oracle.com>
 <1524562426-13008-2-git-send-email-alexey.kodanev@oracle.com>
 <5ADF0183.5080208@cn.fujitsu.com>
Message-ID: <8a9d2d3b-066a-aa08-2d6b-c72a4b6a2349@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 24.04.2018 13:05, Xiao Yang wrote:
> Hi Alexey,
> 
> Thanks for your update.
> 
> If only over-sized INIT packet is tested, Could we remove -a option?
> 

Hi Xiao,

Yes, we could but it still can be useful for debugging, for example
to check whether SCTP server processes it correctly and returns
INIT ACK when we set not so many addresses.  
