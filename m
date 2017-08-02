From: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Date: Wed, 2 Aug 2017 09:50:23 +0300
Subject: [LTP] LTP build issues
In-Reply-To: <20170801213931.gajssq5kldsv46rz@yury-thinkpad>
References: <20170801213931.gajssq5kldsv46rz@yury-thinkpad>
Message-ID: <C7176471-60B5-4397-AB9D-158B39AD53E9@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On Aug 2, 2017, at 12:39 AM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> 
> Hi all,
> 
> I just pulled latest LTP sources and try to build it for the arm64/ilp32 with
> toolchain provided by Linaro.
> http://people.linaro.org/~maxim.kuvyrkov/experimental/<REDACTED>

Please do not share the above link.  This toolchain is not "provided by Linaro", it is uploaded by a developer working at Linaro for early experiments by other developers.  This toolchain was not tested as usual Linaro-released toolchains are.

There is going to be an official "ILP32 preview" cross-toolchain release from Linaro later this month.  We will call it "ILP32 preview" or some such until ILP32 kernel and glibc branches are merged in upstream master branches.

--
Maxim Kuvyrkov
www.linaro.org



