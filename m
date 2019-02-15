From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 15 Feb 2019 13:50:59 +0300
Subject: [LTP] [PATCH 1/4] netstress: support SO_REUSEPORT with new 'P'
 flag
In-Reply-To: <20190214232140.GA12954@x230>
References: <1549908467-15609-1-git-send-email-alexey.kodanev@oracle.com>
 <1549908467-15609-2-git-send-email-alexey.kodanev@oracle.com>
 <20190214232140.GA12954@x230>
Message-ID: <751c56cf-16b0-dc47-6afb-c95adedc0d44@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 15.02.2019 02:21, Petr Vorel wrote:
> Hi Alexey,
> 
>> netstress tool can be used manually by setting -P flag for
>> a server. There is no test-case yet that specifically
>> auto tests this functionality or uses it, but it should be
>> easy to create one. For example, starting multiple netstress
>> instances on the same port.
> 
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Patch-set applied, thanks for review Petr!
