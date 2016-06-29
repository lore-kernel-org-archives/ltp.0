From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 29 Jun 2016 16:49:27 +0300
Subject: [LTP] [PATCH v2] network/ip_route.sh: fix test,
 use dummy/lo interfaces in test-cases
In-Reply-To: <1466098320-14604-1-git-send-email-alexey.kodanev@oracle.com>
References: <1466098320-14604-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <5773D1E7.1060502@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 06/16/2016 08:32 PM, Alexey Kodanev wrote:
> Fixes:
> * 'ip neigh replace' will require lladdr, if the same entry exists, fix it;
> * don't add/del neighbour with 127.0.0.1, as it might affect other tests
>    (this address won't be reachable);
> * don't set mtu to 300, IPv6 requires 1280 bytes as a minimum, so setting
>    less can cause removing of already added IPv6 addresses. Though it's not
>    so important right now as the patch use dummy interface for mtu setting;
> * use ROD library functions;
> * replace 'ifconfig' command with 'ip';
> * adding new route from not used address range.

Applied patch.

Thanks,
Alexey

