From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Fri, 25 Jun 2021 13:55:46 +0200
Subject: [LTP] [PATCH v2 0/3] controllers/memcg: fixes for newer kernels
In-Reply-To: <0042989e-08b8-88d8-75e5-00c09f6c25bb@jv-coder.de>
References: <20210617070730.7699-1-krzysztof.kozlowski@canonical.com>
 <bd56facc-55a3-4e8a-4e9d-304d5177462d@canonical.com>
 <CAEemH2dqM29Y5s5U2QbeONH30h6aR1B4DZxSnSdowWKSXzfgYQ@mail.gmail.com>
 <0042989e-08b8-88d8-75e5-00c09f6c25bb@jv-coder.de>
Message-ID: <8377f0a7-43f9-831c-ffe5-6f10238815e7@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 25/06/2021 11:24, Joerg Vehlow wrote:
>> Forgive me pour cold water on the method though it looks good in coding:).
> I would just suggest to make 32 * PAGESIZE a constant calculated in 
> memcg_lib.sh, instead of calculating (and defining) it everywhere.

I understand that you want to define constant in memcg_lib for a
accepted higher bound of some specific memory limit checks? Won't that
be extra confusing? Trying to generalize some constant without actually
knowing what is it about and to which limits it applies?

Now it's this unknown part is quite local and documented in three
places. I can move it to bigger scope and pretend it's generic, if you want.

Best regards,
Krzysztof
