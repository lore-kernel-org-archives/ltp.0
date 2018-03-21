From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 21 Mar 2018 13:50:32 +0300
Subject: [LTP] [PATCH] busy_poll* : revise poll_cmp
In-Reply-To: <a10e1806-2646-528d-c327-d061affc522b@cn.fujitsu.com>
References: <c999a175-d02b-beda-7418-95a5b0f2d432@cn.fujitsu.com>
 <fae2ea47-a416-f2b4-ee2b-f022f14a14a0@oracle.com>
 <a10e1806-2646-528d-c327-d061affc522b@cn.fujitsu.com>
Message-ID: <4f48b8e7-21ca-088e-24eb-c5b79c3bac18@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On 03/20/2018 03:18 AM, sunlianwen wrote:
> Hi Alexey
>=20
> =C2=A0 You are right, I think is wrong, I debug this case again,
>=20
> and find the driver is virtio_net no support busy poll.


There is support in virtio_net... may be the problem in the underlying
configuration/driver, latency between guest and the other host? you could
also try netperf -H remote_host -t TCP_RR with/without busy_polling:

# sysctl net.core.busy_read=3D50
# sysctl net.core.busy_poll=3D50

Thanks,
Alexey
